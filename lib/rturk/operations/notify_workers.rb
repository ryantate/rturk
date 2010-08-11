#########################################################################
# Operation to send email to a group of workers.                        #
#                                                                       #
# Caveats:                                                              #
#   - A message can only be send to a maximum of 100 workers at a time. #
#   - The message length must be 4096 characters or less.               #
#   - The subject length must be 200 characters or less.                #
#########################################################################

module RTurk
  class NotifyWorkers < Operation
    attr_accessor :worker_ids, :subject, :message_text
    require_params :worker_ids, :subject, :message_text

    def to_params
      message_text.strip!

      if worker_ids.length > 100
        raise ArgumentError, 'Cannot send a message to more than 100 workers at a time.'
      elsif message_text.length > 4096
        raise ArgumentError, 'Message cannot be longer than 4096 characters.'
      elsif subject.length > 200
        raise ArgumentError, 'Subject cannot be longer than 200 characters.'
      end

      id_hash = {}
      worker_ids.each_with_index do |worker_id, index|
        id_hash["WorkerId.#{index}"] = worker_id
      end

      { 'Subject'     => self.subject,
        'MessageText' => self.message_text }.merge(id_hash)
    end
  end

  def self.NotifyWorkers(*args)
    RTurk::NotifyWorkers.create(*args)
  end
end
