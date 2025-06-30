# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :require_login, only: %i[show]
  def show
    # all workshops

    workshops = Workshop.all

    result = []
    workshops.each do |w|
      result << {
        category: w.title,
        group: 'registrations',
        value: w.participants.count
      }

      result << {
        category: w.title,
        group: 'attended',
        value: w.participants.in_attendance.count
      }
    end

    @participation_bar_chart = {
      '$schema': 'https://vega.github.io/schema/vega-lite/v5.json',
      data: {
        values: result
      },
      mark: 'bar',
      encoding: {
        x: {
          field: 'category'
        },
        y: {
          field: 'value',
          type: 'quantitative'
        },
        xOffset: {
          field: 'group'
        },
        color: {
          field: 'group'
        }
      }
    }
    # {
    #   "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
    #   "data": {
    #     "values": [
    #       {"category":"A", "group": "x", "value":0.1},
    #       {"category":"A", "group": "y", "value":0.6},
    #       {"category":"A", "group": "z", "value":0.9},
    #       {"category":"B", "group": "x", "value":0.7},
    #       {"category":"B", "group": "y", "value":0.2},
    #       {"category":"B", "group": "z", "value":1.1},
    #       {"category":"C", "group": "x", "value":0.6},
    #       {"category":"C", "group": "y", "value":0.1},
    #       {"category":"C", "group": "z", "value":0.2}
    #     ]
    #   },
    #   "mark": "bar",
    #   "encoding": {
    #     "x": {"field": "category"},
    #     "y": {"field": "value", "type": "quantitative"},
    #     "xOffset": {"field": "group"},
    #     "color": {"field": "group"}
    #   }
    # }

    # by track

    # by facilitator
  end

  private

  def dashboard_params
    params.permit(:start_date, :end_date)
  end
end
