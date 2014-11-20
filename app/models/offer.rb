class Offer
  include ActiveAttr::Model

  attribute :title
  attribute :payout, type: Integer
  attribute :thumbnail
end
