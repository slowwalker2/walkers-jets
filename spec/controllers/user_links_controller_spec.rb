describe UserLinksController, type: :controller, skip: true do
  describe 'GET /user_links' do
    subject { get '/user_links' }
    
    context '' do
      it '' do
        expect(subject.status).to eq(200)
      end
    end
  end

  describe 'GET /user_links/:id' do
    subject { get "/user_links/#{id}" }
    
    let(:id) { 1}

    context '' do
      it '' do
        expect(subject.status).to eq(200)
      end
    end
  end


  describe 'POST /user_links' do
    subject { post '/user_links', params: params }

    let(:params) do
      {

      }
    end
    
    context '' do
      it '' do
        expect(subject.status).to eq(200)
      end
    end
  end

  describe 'DELETE /user_links/:id' do
    subject { delete "/user_links/#{id}" }

    context '' do
      let(:id) { 1 }

      it '' do
        expect(subject.status).to eq(200)
      end
    end
  end

  describe 'PUT /user_links/:id/rating' do
    subject { post "/user_links/#{id}/rating", params: params }

    let(:params) do
      {

      }
    end

    context '' do
      let(:id) { 1 }

      it '' do
        expect(subject.status).to eq(200)
      end
    end
  end

  describe 'PUT /user_links/:id/note' do
    subject { post "/user_links/#{id}/note", params: params }
    
    let(:params) do
      {
        user_link: {
          note: 'note'
        }
      }
    end

    context '' do
      let(:id) { 1 }

      it '' do
        expect(subject.status).to eq(200)
      end
    end
  end
end
