# Create skincare category
skin_care = Category.create(name: "Skin Care")

cleanse = Category.create(name: "Cleanse")
cleanse.move_to_child_of(skin_care)
toner = Category.create(name: "Toner")
toner.move_to_child_of(cleanse)
facial_cleanser = Category.create(name: "Facial Cleanser")
facial_cleanser.move_to_child_of(cleanse)

# Setup skincare products
# Category level product
skin_care_product = Product.new(name: "skincare product", price: 13)
skin_care_product.category = skin_care
skin_care_product.save
# Sub category level product
cleanse_product = Product.new(name: "cleanse product", price: 13)
cleanse_product.category = cleanse
cleanse_product.save
#Sub sub category level product
toner_product = Product.new(name: "toner product", price: 12)
toner_product.category = toner
toner_product.save
# Product without category
Product.create(name: "Bar soap", price: 15)

facial_cleanser_product = Product.new(name: "facial cleanser product", price: 12)
facial_cleanser_product.category = facial_cleanser
facial_cleanser.save

# Create eyecare category
eye_care = Category.create(name: "Eye Care")
eye_care.move_to_child_of(skin_care)
eye_mask = Category.create(name: "Eye Mask")
eye_mask.move_to_child_of(eye_care)
eye_cream = Category.create(name: "Eye Cream")
eye_cream.move_to_child_of(eye_care)

#Create lip care category
lip_care = Category.create(name: "Lip Care")
lip_care.move_to_child_of(skin_care)
lip_mask = Category.create(name: "Lip Mask")
lip_mask.move_to_child_of(lip_care)
lip_balm = Category.create(name: "Lip Balm")
lip_balm.move_to_child_of(lip_care)

# Create make up category
make_up = Category.create(name: "Make Up")

eyes = Category.create(name: "Eye")
eyes.move_to_child_of(make_up)
eyebrow = Category.create(name: "Eyebrow")
eyebrow.move_to_child_of(eyes)
mascara = Category.create(name: "Mascara")
mascara.move_to_child_of(eyes)

face = Category.create(name: "Face")
face.move_to_child_of(make_up)
concealer = Category.create(name: "Concealer")
concealer.move_to_child_of(make_up)
foundation = Category.create(name: "Foundation")
foundation.move_to_child_of(make_up)
