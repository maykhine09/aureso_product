json.expire_date @product.expire_date.present? ? @product.expire_date.strftime('%Y-%m-%d') : ''
json.name @product.name
json.collection_id @product.id
json.SKU_ID @product.SKU_ID.present? ? @product.SKU_ID : ''
json.categories @product.categories.pluck(:name)
json.tags @product.tag_list
json.images @product.product_pictures, :url
json.price @product.price
json.description @product.description.present? ? @product.description : ''
