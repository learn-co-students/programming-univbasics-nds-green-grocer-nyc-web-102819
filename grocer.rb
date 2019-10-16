def find_item_by_name_in_collection(name, collection)
  collection.each{ |item|
    if item[:item] == name
      return item
    end
  }
  nil
end

def consolidate_cart(cart)
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
  cart.length.times {|i|
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price]*0.8).round(2)
    end
  }
  cart
end

def checkout(cart, coupons)
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
