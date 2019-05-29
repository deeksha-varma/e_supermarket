class Product < ActiveRecord::Base
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :categories, allow_destroy: true,
    reject_if: :all_blank
  serialize :images

  attr_accessor :category_names, :category_ids, :categories_attributes
  after_save :assign_categories

  validates :name, :description, :expire_date, :price, presence: true
  validates :sku_id, uniqueness: true
  validate :create_new_category, on: :update
  
  def categories_attributes=(category_attributes)
    if category_attributes.values.first["name"].present?
      category_attributes.values.each do |category_attribute|
        category = Category.find_or_create_by(category_attribute)
        self.categories << category
      end
    end
  end

  def self.category_names
    @category_names || categories.map(&:name).uniq.join(', ')
  end

  def create_new_category
    if category_ids.blank?
      errors.add(:base, "Please select a category from the list or add a new category")
    end
  end

  private

    def assign_categories
      if @category_names #create category association on POST API
        self.category_names = @category_names.map do |name| 
          categories = Category.where(name: name).first_or_create!
          self.product_categories.create(category: categories)
        end
      else
        self.categories = update_product_categories
      end
    end

    def update_product_categories
      if @category_ids.blank?
        product_categories = ProductCategory.where(product_id: self.try(:id)) 
        new_category_created = product_categories.sort_by(&:created_at).first.category if product_categories.present?
        self.categories << Category.where(id: new_category_created.id) if new_category_created
      else
        self.categories = []
        self.categories |= Category.where(id: [@category_ids])
      end
      self.categories
    end
end