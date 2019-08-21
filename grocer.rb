

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

def apply_coupons(cart, coupons)
  cartHash = Hash.new
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] -= coupon[:num]
          
          if cartHash["#{food} W/COUPON"]
            cartHash["#{food} W/COUPON"][:count] += 1
          else
            cartHash["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
          end
      end
  end
  cartHash[food] = info
end
cartHash
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

