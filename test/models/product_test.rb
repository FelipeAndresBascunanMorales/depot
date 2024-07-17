require "test_helper"

class ProductTest < ActiveSupport::TestCase
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

  
end
