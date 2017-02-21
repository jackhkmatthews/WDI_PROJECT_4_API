class IncomeStatementScraper < ParserAndScraper

  def get_date_divs
    query = "//body//tr//th[@class='th']"
    @date_divs = get_nokogiri_objects(query)[1..-1]
  end

  def create_yearly_results_hash date, column_index
    {
      IS_id: 1,
      year: get_year_integer(date),
      date: date,
      UNITS: get_units,
      SALES: get_cell_float("SALES", column_index),
      COGS: get_cell_float("COGS", column_index),
      EBIT: get_cell_float("EBIT", column_index),
      PBT: get_cell_float("PBT", column_index),
      TAX: get_cell_float("TAX", column_index),
      NET_INCOME: get_cell_float("NET_INCOME", column_index),
      BASIC_EPS: get_cell_float("BASIC_EPS", column_index),
      DILUTED_EPS: get_cell_float("DILUTED_EPS", column_index)
    }
  end

  def initialize file, onclick_terms
    @onclick_terms = onclick_terms
    parse_file file
    initialize_data_array
    get_date_divs
    get_date_strings
    get_document_period_end_date
    populate_data_array_with_cells
    Pry::ColorPrinter.pp(@data)
  end

end
