require 'rails_helper'
# Specs in this file have access to a helper object that includes
# the PagespeedInsightsHelperHelper. For example:
#
# describe PagespeedInsightsHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PagespeedInsightsHelper, type: :helper do
  describe '#progress' do
    it 'returns the instance variable of progress' do
      expect(helper.progress(0)).to eq(:success)
      expect(helper.progress(1)).to eq(:info)
      expect(helper.progress(2)).to eq(:danger)
    end
  end

  describe '#get_data' do
    it 'gets the data' do
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
    it 'gets the distribution proportion' do
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
    it 'sets the proportion of distribution' do
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
    it 'should set data for origin or field' do
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

      expect(new_field).to have_key('category')
      expect(new_field).to have_key('first_value')
      expect(new_field).to have_key('second_value')
      expect(new_field).to have_key('third_value')
    end
  end

  describe '#set_parameters' do
    it 'should set parameters for pagespeed insight' do
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

      pagespeed_insight = FactoryBot.build(:pagespeed_insight)
      pagespeed = set_parameters(field, origin, lighthouse, pagespeed_insight)
      expect(pagespeed).not_to eq(nil)
    end
  end
end
