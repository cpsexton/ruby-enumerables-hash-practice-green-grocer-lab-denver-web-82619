require 'pry'

def consolidate_cart(cart)
  # code here
    consolidated_cart = {}
    cart.each do |item|
        item.each do |name, attributes|
            attributes[:count] = cart.count(item)
        end
    consolidated_cart.merge!(item)
    end
    consolidated_cart
end
=begin
def apply_coupons(cart, coupons)
  cartHash = {}
  cart.each do |food, info|
  cartHash[food] = info  
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        cartHash[food][:count] = cartHash[food][:count] -= coupon[:num]
          if cartHash["#{food} W/COUPON"]
            cartHash["#{food} W/COUPON"][:count] += 1
          else
            cartHash["#{food} W/COUPON"] = {:price => coupon[:cost], :count => 1}
            cartHash["#{food} W/COUPON"][:clearance] = cartHash[food][:clearance]
          end
      end
  end
  #cartHash[food] = info
end
cartHash
end
=end

def apply_coupons(cart, coupons)
  # code here
  new_hash = {}
  cart.each do |food, value|
    coupons.each do |coupon|
      if food == coupon[:item] && cart[food][:count] >= coupon[:num]
        cart[food][:count] = cart[food][:count] - coupon[:num]
        if new_hash["#{food} W/COUPON"]
        new_hash["#{food} W/COUPON"][:count] += 1
      else
        new_hash["#{food} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => value[:clearance],
          :count => 1
        }
        end
      end
    end
    new_hash[food] = value
  end
  new_hash
end



def apply_clearance(cart)
  cartHash = cart
  cart.each do |name, hash|
    if hash[:clearance] 
      cartHash[name][:price] = (cart[name][:price] * 0.8).round(2)
    end
  end
 cartHash
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each do |food, info|
    total += (info[:price] * info[:count]).to_f
  end
  total >= 100 ? total * 0.9 : total
  end

