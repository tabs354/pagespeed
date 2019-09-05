require 'rails_helper'

RSpec.describe PagespeedInsightsHelper, type: :helper do
  describe '#progress' do
    it 'should return the data of progress with given index and must be equal to constants :success, :info, and :danger' do
      expect(helper.progress(0)).to eq(:success)
      expect(helper.progress(1)).to eq(:info)
      expect(helper.progress(2)).to eq(:danger)
    end
  end

  describe '#get_data' do
    it 'should get the category and must be equal to the given category data. In this case SLOW' do
      field = {
          'metrics' => {
              'FIRST_CONTENTFUL_PAINT_MS' => {
                  'category' => 'SLOW'
              }
          }
        }

      expect(helper.get_data(field,'FIRST_CONTENTFUL_PAINT_MS')).to eq('SLOW')
    end
  end

  describe '#get_distribution' do
    it 'should get the distribution proportion and expect to have 3 keys.' do
      field = {
          'metrics' => {
              'FIRST_CONTENTFUL_PAINT_MS' => {
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.50},
                      2 => {'proportion' => 0.50},
                  }
              }
          }
      }

      expect(helper.get_distribution(field,'FIRST_CONTENTFUL_PAINT_MS')).to have_key(0)
      expect(helper.get_distribution(field,'FIRST_CONTENTFUL_PAINT_MS')).to have_key(1)
      expect(helper.get_distribution(field,'FIRST_CONTENTFUL_PAINT_MS')).to have_key(2)
    end
  end

  describe '#set_proportion' do
    it 'should get the proportion data with its value multiplied by 100' do
      field = {
          'metrics' => {
              'FIRST_CONTENTFUL_PAINT_MS' => {
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.26},
                      2 => {'proportion' => 0.24},
                  }
              }
          }
      }

      distributions = helper.get_distribution(field, 'FIRST_CONTENTFUL_PAINT_MS')
      expect(helper.set_proportion(distributions[0])).to eq(50)
      expect(helper.set_proportion(distributions[1])).to eq(26)
      expect(helper.set_proportion(distributions[2])).to eq(24)
    end
  end

  describe '#set_origin_or_field' do
    it 'should set data for origin or field and expect to have 4 keys' do
      field = {
          'metrics' => {
              'FIRST_CONTENTFUL_PAINT_MS' => {
                  'category' => 'SLOW',
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.26},
                      2 => {'proportion' => 0.24},
                  }
              }
          }
      }

      new_field = helper.set_origin_or_field(field,'FIRST_CONTENTFUL_PAINT_MS')

      expect(new_field.keys.count).to eq(4)
    end
  end

  describe '#set_parameters' do
    it 'should set parameters for pagespeed insight and expect that pagespeed insight column values not equal to nil' do
      field = {
          'metrics' => {
              'FIRST_CONTENTFUL_PAINT_MS' => {
                  'category' => 'SLOW',
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.26},
                      2 => {'proportion' => 0.24},
                  }
              },
              'FIRST_INPUT_DELAY_MS' => {
                  'category' => 'AVERAGE',
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.26},
                      2 => {'proportion' => 0.24},
                  }
              }
          }
      }

      origin  = {
          'metrics' => {
              'FIRST_CONTENTFUL_PAINT_MS' => {
                  'category' => 'SLOW',
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.26},
                      2 => {'proportion' => 0.24},
                  }
              },
              'FIRST_INPUT_DELAY_MS' => {
                  'category' => 'AVERAGE',
                  'distributions' => {
                      0 => {'proportion' => 0.50},
                      1 => {'proportion' => 0.26},
                      2 => {'proportion' => 0.24},
                  }
              }
          }
      }

      lighthouse = {
          'first-contentful-paint' => {'displayValue' => '0.6 s'},
          'first-meaningful-paint' => {'displayValue' => '0.6 s'},
          'estimated-input-latency' => {'displayValue' => '10 ms'},
          'interactive' => {'displayValue' => '1.1 s'},
          'first-cpu-idle' => {'displayValue' => '0.9 s'},
          'speed-index' => {'displayValue' => '0.6 s'},

      }

      pagespeed = set_parameters(field, origin, lighthouse, build(:pagespeed_insight))

      expect(pagespeed.lighthouse_result).not_to eq(nil)
      expect(pagespeed.overall_results).not_to eq(nil)
      expect(pagespeed.field_paint).not_to eq(nil)
      expect(pagespeed.field_input).not_to eq(nil)
      expect(pagespeed.origin_paint).not_to eq(nil)
      expect(pagespeed.origin_input).not_to eq(nil)
    end
  end
end
