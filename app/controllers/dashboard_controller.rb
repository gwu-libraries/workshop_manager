class DashboardController < ApplicationController
  def show
    @bar_chart =
      Vega
        .lite
        .data(
          [
            { city: 'A', sales: 28 },
            { city: 'B', sales: 55 },
            { city: 'C', sales: 43 }
          ]
        )
        .mark(type: 'bar', tooltip: true)
        .encoding(
          x: {
            field: 'city',
            type: 'nominal'
          },
          y: {
            field: 'sales',
            type: 'quantitative'
          }
        )
  end

  private

  def dashboard_params
    params.permit(:start_date, :end_date)
  end
end
