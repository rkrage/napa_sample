class CheckInApi < Grape::API

  namespace :check_ins do

    before do
      token_authenticate!
    end

    desc 'Get a list of check_ins for signed in user'
    params do
      optional :ids, type: Array, desc: 'Array of check_ins ids'
    end
    get do
      check_ins = @current_user.check_ins
      check_ins = check_ins.where(id: params[:ids]) if params[:ids]
      present check_ins, with: CheckInRepresenter
    end

    desc 'Create a check_in for signed in user'
    params do
      requires :name, type: String, desc: 'Name of the location'
      requires :message, type: String, desc: 'Message about the check in'
      optional :lat, type: Float, desc: 'Latitude of location'
      optional :lng, type: Float, desc: 'Longitude of location'
    end
    post do
      check_in = @current_user.check_ins.create!(permitted_params)
      present check_in, with: CheckInRepresenter
    end

    params do
      requires :id, desc: 'ID of the check_in'
    end
    route_param :id do
      desc 'Get a check_in for signed in user'
      get do
        check_in = @current_user.check_ins.find(params[:id])
        present check_in, with: CheckInRepresenter
      end

      desc 'Update a check_in for signed in user'
      params do
        optional :name, type: String, desc: 'Name of the location'
        optional :message, type: String, desc: 'Message about the check in'
        optional :lat, type: Float, desc: 'Latitude of location'
        optional :lng, type: Float, desc: 'Longitude of location'
      end
      put do
        check_in = @current_user.check_ins.find(params[:id])
        check_in.update_attributes!(permitted_params)
        present check_in, with: CheckInRepresenter
      end
    end

  end

end
