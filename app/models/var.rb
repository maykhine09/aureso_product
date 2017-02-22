class Var < ActiveRecord::Base
  belongs_to :product
  has_many :models, dependent: :destroy

  def self.check_and_create(product,vars_params)
    params = JSON.parse(vars_params.to_s)
    if params["color"].present?
      @vars = Var.create(:product_id => product.id, :color => params["color"])
      if params["models"].present?
        models = params["models"]
        models.each do |m|
          Model.create(:var_id => @vars.id, :name => m)
        end
      end
    end
  end
end
