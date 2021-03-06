class Filing < ApplicationRecord
  belongs_to :company
  has_many :bs_yearly_results
  has_many :is_yearly_results
  has_many :cf_yearly_results
  has_one :dei_statement

  validates :accession_id, presence: true, uniqueness: true
end
