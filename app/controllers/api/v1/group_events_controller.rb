# frozen_string_literal: true

module Api
  module V1
    class GroupEventsController < ApplicationController
      before_action :set_group_event, only: %i[show update destroy]

      def index
        json_response(GroupEvent.all)
      end

      def show
        json_response(@group_event)
      end

      def create
        @group_event = GroupEvent.create!(group_event_params)
        json_response(@group_event, :created)
      end

      def update
        @group_event.update!(group_event_params)
        json_response(@group_event)
      end

      def destroy
        @group_event.destroy
        head :no_content
      end

      private

      def group_event_params
        params
          .require(:group_event)
          .permit(:name, :description, :duration, :start_date, :end_date, :published, :location)
      end

      def set_group_event
        @group_event = GroupEvent.find(params[:id])
      end
    end
  end
end
