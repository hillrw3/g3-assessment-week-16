require 'csv'

class PlantMetricsAnalyzer

  def initialize(file)
    @file = file
  end

  def read_file
    CSV.read(@file, {:col_sep => "\t"})
  end

  def pH(*container)
    container = container.pop
    pH = []
    read_file.each do |line|
      if container == nil
        pH << line[2].to_f
      else
        pH << line[2].to_f if line[1] == container
      end
    end
    average(pH).round(2)
  end

  def nutrient_level(*container)
    container = container.pop
    nutrient_level = []
    read_file.each do |line|
      if container == nil
        nutrient_level << line[3].to_f
      else
        nutrient_level << line[3].to_f if line[1] == container
      end
    end
    average(nutrient_level).round(2)
  end

  def temperature(*container)
    container = container.pop
    temperature = []
    read_file.each do |line|
      if container == nil
        temperature << line[4].to_f
      else
        temperature << line[4].to_f if line[1] == container
      end
    end
    average(temperature).round(2)
  end

  def water_level(*container)
    container = container.pop
    water_level = []
    read_file.each do |line|
      if container == nil
        water_level << line[5].to_f
      else
        water_level << line[5].to_f if line[1] == container
      end
    end
    average(water_level).round(2)
  end

  def average(array)
    total = array.inject(:+)
    total / array.length
  end

  def container_average(*container)
    container = container.pop
    container_hash = {"#{container != nil ? container : "all containers"}" => {
      pH: pH(container),
      nutrient_solution_level: nutrient_level(container),
      temperature: temperature(container),
      water_level: water_level(container),
    }}
    container_hash
  end

  def highest_avg_temp
    avg_temps = [temperature("container1"), temperature("container2"), temperature("container3")]
    container_index = avg_temps.find_index(avg_temps.max)
    "container#{container_index + 1}"
  end

  def highest_water_level
    water_level = [water_level("container1"), water_level("container2"), water_level("container3")]
    container_index = water_level.find_index(water_level.max)
    "container#{container_index + 1}"
  end

  def highest_pH
    pH_levels = [pH("container1"), pH("container2"), pH("container3")]
    container_index = pH_levels.find_index(pH_levels.max)
    "container#{container_index + 1}"
  end

end

p PlantMetricsAnalyzer.new("data/metrics.tsv").highest_pH