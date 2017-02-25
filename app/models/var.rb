class Var < ActiveRecord::Base
  belongs_to :product
  has_many :models, dependent: :destroy

  accepts_nested_attributes_for :models, :allow_destroy => true

  def self.check_and_create(product,vars_params,model_params)
    color = ""
    if params["color"].present?
      color = vars_params[:color]
    end
    @vars = Var.create(:product_id => product.id, :color => color)
    if model_params["name"].present?
      models = model_params["name"].split(",").map(&:strip)
      models.each do |m|
        Model.create(:var_id => @vars.id, :name => m)
      end
    end
  end
end
