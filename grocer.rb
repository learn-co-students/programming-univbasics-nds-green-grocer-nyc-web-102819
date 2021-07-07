require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  result = {}
  i = 0

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

#binding.pry

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  cart1 = cart
  cart2 = []
  i = 0 # element numnber in cart1
  while i < cart1.count do

    item_name = cart1[i][:item]
    item_price = cart1[i][:price]
    item_clearance = cart1[i][:clearance]
    new_item = {item:item_name, price: item_price, clearance: item_clearance, count: 1}

    # element => element number in cart2

    if cart2.any? {|element| element[:item] == item_name}

      cart2.each { |element|
                                if element[:item] == item_name
                                  element[:count] += 1
                                end
                                }
    else
      cart2.push(new_item)
    end
    i += 1
  end
  cart2
end



def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart1 = coupons
  cart2 = cart
  i = 0 # element numnber in cart1
  while i < cart1.count do

    cart1_item = cart1[i][:item]
    cart1_cost = cart1[i][:cost]
    cart1_num = cart1[i][:num]

    cart2_newPrice = cart1_cost/cart1_num

    # element => element number in cart2

    cart2.each { |element|
               if element[:item] == cart1_item && element[:count] >= cart1_num

                 cart2.push({item: cart1_item + " W/COUPON",
                            price: cart2_newPrice,
                            clearance: element[:clearance],
                            count: cart1_num
                            })
                 element[:count] -= cart1_num

               end
              }
    i += 1
  end
  cart2

end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart1 = cart
  cart2 = []

    # element => element number in cart1

    cart1.each { |element|
               if element[:clearance] #== true

                cart2.push({item:     element[:item],
                            price:    (element[:price]*0.8).round(2),
                            clearance: element[:clearance],
                            count:     element[:count]
                          })
              else
                cart2.push(element)

              end
              }
  cart2

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

  cart_1 = consolidate_cart(cart)

  cart_2 = apply_coupons(cart_1, coupons)

  cart_3 = apply_clearance(cart_2)

  grand_total = 0
  cart_3.each { |element| grand_total += element[:price] * element[:count]}

  final_total = 0
  if grand_total >100
    final_total = grand_total*0.9
  else
    final_total = grand_total
  end

  final_total.round(2)

end
