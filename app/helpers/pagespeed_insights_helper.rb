module PagespeedInsightsHelper
  def progress(index)
    progress = [:success, :info, :danger]
    progress[index]
  end

  def get_data(data, content)
    data["metrics"][content]["category"]
  end

  def get_distribution(data, content)
    data["metrics"][content]["distributions"]
  end

  def set_proportion(distribution)
    distribution["proportion"] * 100
  end

  def set_parameters(field, origin, lighthouse, pagespeed)
    #Lighthouse
    pagespeed.lighthouse_result = {"contentful_paint" => lighthouse["first-contentful-paint"]["displayValue"],
                                   "meaningful_paint" => lighthouse["first-meaningful-paint"]["displayValue"],
                                   "input_latency"    => lighthouse["estimated-input-latency"]["displayValue"],
                                   "interactive"      => lighthouse["interactive"]["displayValue"],
                                   "cpu_idle"         => lighthouse["first-cpu-idle"]["displayValue"],
                                   "speed_index"      => lighthouse["speed-index"]["displayValue"]}

    #Field Paint
    field_paint_distributions = get_distribution(field, "FIRST_CONTENTFUL_PAINT_MS")
    pagespeed.field_paint = {
        "category"     => get_data(field, "FIRST_CONTENTFUL_PAINT_MS"),
        "first_value"  => set_proportion(field_paint_distributions[0]),
        "second_value" => set_proportion(field_paint_distributions[1]),
        "third_value"  => set_proportion(field_paint_distributions[2])
    }

    #Field Paint
    field_input_distributions = get_distribution(field, "FIRST_INPUT_DELAY_MS")
    pagespeed.field_input = {
        "category"     => get_data(field, "FIRST_INPUT_DELAY_MS"),
        "first_value"  => set_proportion(field_input_distributions[0]),
        "second_value" => set_proportion(field_input_distributions[1]),
        "third_value"  => set_proportion(field_input_distributions[2])
    }

    #Origin Paint
    origin_paint_distributions = get_distribution(origin, "FIRST_CONTENTFUL_PAINT_MS")
    pagespeed.origin_paint = {
        "category"     => get_data(origin, "FIRST_CONTENTFUL_PAINT_MS"),
        "first_value"  => set_proportion(origin_paint_distributions[0]),
        "second_value" => set_proportion(origin_paint_distributions[1]),
        "third_value"  => set_proportion(origin_paint_distributions[2])
    }

    #Origin Paint
    origin_input_distributions = get_distribution(origin, "FIRST_INPUT_DELAY_MS")
    pagespeed.origin_input = {
        "category"     => get_data(origin, "FIRST_INPUT_DELAY_MS"),
        "first_value"  => set_proportion(origin_input_distributions[0]),
        "second_value" => set_proportion(origin_input_distributions[1]),
        "third_value"  => set_proportion(origin_input_distributions[2])
    }

    #Return
    pagespeed
  end
end