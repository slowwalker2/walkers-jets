module UserLinksHelper
  def to_response(record)
    response = record.as_json
    response['rating'] = record.user_link_stars
    response['note'] = record.user_link_note
    response
  end

  def to_responses(records)
    records.map do |record|
      to_response(record)
    end
  end
end
