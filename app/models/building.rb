class Building
  attr_reader :id, :name, :address, :height, :construction_date, :architect
  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @address = input_options["address"]
    @height = input_options["height"]
    @construction_date = input_options["construction_date"]
    @architect = input_options["architect"]
  end

  def self.find(input_id) # for show
    response = HTTP.get("http://localhost:3000/api/buildings/#{input_id}")
    hash_data = response.parse
    Building.new(hash_data)
  end

  def self.all # for index
    response = HTTP.get("http://localhost:3000/api/buildings")
    array_of_hashes = response.parse
    array_of_hashes.map do |hash|
      Building.new(hash)
    end 
  end
  def self.create(input_options) # for create
    response = HTTP.post("http://localhost:3000/api/buildings",
                    form: input_options
                        )
    input_options = response.parse
    input_options.map do |option|
      Building.new(hash)
    end
  end
end