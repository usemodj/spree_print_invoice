if @hide_prices
  @column_widths = { 0 => 100, 1 => 165, 2 => 75, 3 => 75 } 
  @align = { 0 => :left, 1 => :left, 2 => :right, 3 => :right }
else
  @column_widths = { 0 => 75, 1 => 205, 2 => 75, 3 => 50, 4 => 75, 5 => 60 } 
  @align = { 0 => :left, 1 => :left, 2 => :left, 3 => :right, 4 => :right, 5 => :right}
end

# Line Items
bounding_box [0,cursor], :width => 540, :height => 430 do
  move_down 2
  header =  [t(:sku),t(:item_description)]
  header <<  t(:options)
  header <<  t(:price) unless @hide_prices
  header <<  t(:qty)
  header <<  t(:total) unless @hide_prices
    
  table [header], :cell_style => {:font_style => :bold,:border_width => 1,:padding => [2,6,2,6],:size => 9},
    :position  => :center,
    :column_widths => @column_widths
    

  move_down 4

  bounding_box [0,cursor], :width => 540 do
    move_down 2
    content = []
    @order.line_items.each do |item|
      row = [ item.variant.product.sku, item.variant.product.name]
      row << item.variant.option_values.map {|ov| "#{ov.option_type.presentation}: #{ov.presentation}"}.concat(item.respond_to?('ad_hoc_option_values') ? item.ad_hoc_option_values.map {|pov| "#{pov.option_value.option_type.presentation}: #{pov.option_value.presentation}"} : []).join(', ')
      row << number_to_currency(item.price) unless @hide_prices
      row << item.quantity
      row << number_to_currency(item.price * item.quantity) unless @hide_prices
      content << row
    end


    table content, :cell_style => {:border_width => 0.5, :padding => [5,6,5,6],:size => 9},
          :position => :center,
          :column_widths => @column_widths 
      end
    
      font "Helvetica", :size => 9
    
      bounding_box [20,cursor  ], :width => 400 do
        render :partial => "bye" unless @hide_prices
      end

  render :partial => "totals" unless @hide_prices
  
  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end
