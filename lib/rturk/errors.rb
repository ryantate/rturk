module RTurk
  class RTurkError < StandardError; end;
  class MissingParameters < RTurkError; end;
end