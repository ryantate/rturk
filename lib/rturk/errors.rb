module RTurk
  class RTurkError < StandardError; end;
  class MissingParameters < RTurkError; end;
  class InvalidRequest < RTurkError; end;
  class ServiceUnavailable < RTurkError; end;
end