require 'spec_helper'

describe "Plant Metrics Analyzer" do

      analyzer = PlantMetricsAnalyzer.new("data/metrics.tsv")

  it "should return average of metrics for all plants" do
    expect(analyzer.container_average).to eq({"all containers"=>{:pH=>5.99, :nutrient_solution_level=>23.25, :temperature=>66.15, :water_level=>3.54}})
  end

end