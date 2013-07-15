totals = []

totals << [{:content => t(:subtotal), :font_style => :bold}, number_to_currency(@order.item_total)]

@order.adjustments.each do |charge|
  totals << [{:content => charge.label + ":", :font_style => :bold}, number_to_currency(charge.amount)]
end

totals << [{:content => t(:order_total), :font_style => :bold}, number_to_currency(@order.total)]

bounding_box [bounds.right - 500, bounds.bottom + (totals.length * 18)], :width => 500 do
  table totals,:cell_style => {:border_width => 0,:padding => [2,6,2,6],:size => 9},
    :position => :right,
    :column_widths => { 0 => 425, 1 => 75 } #,
    #:align => { 0 => :right, 1 => :right }

end
