require "sinatra"
require "units_converter"

class ConversionsApp < Sinatra::Base
  get "/" do
    @available_units = UnitsConverter::CONVERSIONS_TO_METRES.keys.map {|unit|
      ActiveSupport::Inflector.pluralize(unit)
    }

    @quantity_in_old_units = BigDecimal.new(params[:quantity_in_old_units] || 10)
    @old_unit = params[:old_unit] || "kilometres"
    @new_unit = params[:new_unit] || "miles"

    if @quantity_in_old_units && @old_unit && @new_unit
      @quantity_in_new_units = UnitsConverter.convert(@quantity_in_old_units, @old_unit).to(@new_unit)
    end

    erb :root
  end
end
