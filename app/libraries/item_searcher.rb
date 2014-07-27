class ItemSearcher
  include ActiveAttr::Model

  attribute :query
  
  def search
    items = Item.listable.order("items.id desc")
    items = items.includes(:organization)
    items = items.where("accounts.deleted_at" => nil).references(:organization)
    if query && (q = query.strip).present?
      columns = %w(items.display_name accounts.screen_name accounts.real_name)
      condition = columns.map {|col| "(#{col} like ?)" }.join(' or ')
      values = []
      3.times do
        values << "%#{q}%"
      end
      items = items.where(condition, *values).references(:organization)
    end
    items
  end
end
