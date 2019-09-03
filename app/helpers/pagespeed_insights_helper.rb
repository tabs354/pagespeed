module PagespeedInsightsHelper
  def progress(index)
    progress = [:success, :info, :danger]
    progress[index]
  end

  def get_data(data, content)
    data['metrics'][content]['category']
  end

  def get_distribution(data, content)
    data['metrics'][content]['distributions']
  end

  def set_proportion(distribution)
    distribution['proportion'] * 100
  end

  def set_origin_or_field(data, content)
    distributions = get_distribution(data, content)
    origin_or_field_data = {
        'category' => get_data(data, content),
        'first_value' => set_proportion(distributions[0]),
        'second_value' => set_proportion(distributions[1]),
        'third_value' => set_proportion(distributions[2])
    }
  end

  def set_parameters(field, origin, lighthouse, pagespeed)
    pagespeed.lighthouse_result = {'contentful_paint' => lighthouse['first-contentful-paint']['displayValue'],
                                   'meaningful_paint' => lighthouse['first-meaningful-paint']['displayValue'],
                                   'input_latency' => lighthouse['estimated-input-latency']['displayValue'],
                                   'interactive' => lighthouse['interactive']['displayValue'],
                                   'cpu_idle' => lighthouse['first-cpu-idle']['displayValue'],
                                   'speed_index' => lighthouse['speed-index']['displayValue']}
    pagespeed.overall_results = {'field' => field['overall_category'], 'origin' => origin['overall_category']}
    pagespeed.field_paint = set_origin_or_field(field, 'FIRST_CONTENTFUL_PAINT_MS')
    pagespeed.field_input = set_origin_or_field(field, 'FIRST_INPUT_DELAY_MS')
    pagespeed.origin_paint = set_origin_or_field(origin, 'FIRST_CONTENTFUL_PAINT_MS')
    pagespeed.origin_input = set_origin_or_field(origin, 'FIRST_INPUT_DELAY_MS')
    pagespeed
  end
end