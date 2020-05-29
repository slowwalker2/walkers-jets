class ApplicationController < Jets::Controller::Base
  skip_forgery_protection

  PER = 20
end
