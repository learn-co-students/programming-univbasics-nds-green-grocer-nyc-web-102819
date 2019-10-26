def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  result={}
  i=0 
  while i < collection.count do

    if name != collection[i][:item]
      i += 1
    else
      result = collection[i]
      i += 1
    end
  end
  if result == {}
    return nil
  else
    result
  end
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing
  
    item_names = []
  item_count_hash = {}
  cart.each{ |item|
    item_names.append(item[:item])
  }
  item_names_uniq = item_names.uniq
  item_names_uniq.length.times { |i|
    item_count_hash[item_names_uniq[i]] = item_names.count(item_names_uniq[i])
  }

  consolidated_cart = []
  item_names_uniq.length.times { |i|
    hash = find_item_by_name_in_collection(item_names_uniq[i], cart)
    hash[:count] = item_count_hash[item_names_uniq[i]]
    consolidated_cart.append(hash)
  }

  consolidated_cart

end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart1=coupons
  cart2 = cart
  i = 0 # element numnber in cart1
  while i < cart1.count do

    cart1_item = cart1[i][:item]
    cart1_cost = cart1[i][:cost]
    cart1_num = cart1[i][:num]

    cart2_newPrice = cart1_cost/cart1_num

    # element => element number in cart2

  coupon_applied_cart = cart
  cart.length.times { |i|
    coupons.length.times { |j|
      if cart[i][:item] == coupons[j][:item] && coupons[j][:num] <= cart[i][:count]
        coupon_applied_cart[i][:count] -= coupons[j][:num]
        coupon_applied_cart.append({
          :item => "#{cart[i][:item]} W/COUPON",
          :price => (coupons[j][:cost])/(coupons[j][:num]),
          :clearance => cart[i][:clearance],
          :count => coupons[j][:num]
        })
      end
    }
  }
  coupon_applied_cart
  
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.length.times {|i|
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price]*0.8).round(2)
    end
  }
  cart


end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
   cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  cart.length.times {|i|
    total += cart[i][:price]*cart[i][:count]
  }
  if total > 100
    total *= 0.9
  end
  total
  
end
