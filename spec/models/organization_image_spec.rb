require 'spec_helper'

describe OrganizationImage, '#save' do
  Given(:organization_image) { create(:organization_image) }
  Then { expect(organization_image.created_at).to eq(TimeZero) }
  Then { expect(organization_image.updated_at).to eq(TimeZero) }
  Then { expect(organization_image.data).not_to be_nil }
  Then { expect(organization_image.thumbnail_data).not_to be_nil }
end
