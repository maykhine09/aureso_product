empty = {}
json.expire_date @product.expire_date.present? ? @product.expire_date.strftime('%Y-%m-%d') : ''
json.name @product.name
json.collection_id @product.id
json.SKU_ID @product.SKU_ID.present? ? @product.SKU_ID : ''
json.categories @product.categories.pluck(:name)
json.tags @product.tag_list
vars = @product.vars.first
if vars.present?
  json.vars do
    json.color vars.color
    json.models vars.models.pluck(:name)
  end
else
  json.vars empty
end
json.images @product.product_pictures, :url
json.price @product.price
json.description @product.description.present? ? @product.description : ''
