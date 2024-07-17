require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title", description: "asdf", image_url: "asdf.jpg", price: -1)
    assert product.invalid?
  
    product.price = 1
  
    assert product.valid?
  end
  
  test "image_url must have a valid extension" do
    valid_urls = %w[ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif ]
    invalid_urls = %w[ fred.doc fred.gif/more fred.gif.more ]
  
    valid_urls.each do |url|
      assert Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: url).valid?, "#{url} should be valid"
    end
  
    invalid_urls.each do |url|
      assert Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: url).invalid?, "#{url} should be invalid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")

    assert product.invalid?
    
    assert product.errors[:title].any?("has already been taken")
  end

  test "product title must be at least 10 characters long" do
    product = Product.new(title: "short",
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")

    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]

    product.title = "long enough to be dangerous"
    assert product.valid?
  end
  
end
