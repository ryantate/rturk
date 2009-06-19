module RTurk::Actions
  require 'cgi'
  # Overides createHIT to allow for easier entry
  def createHIT(props, page)
    props = format_props(props)
    props = props.merge(:Question => page, :Operation => 'CreateHIT')
    request(props)
  end

  private

  def format_props(params)
    params = stringify_keys(params)
    reward = params['Reward']
    qualifiers = params['QualificationRequirement']
    params.delete('Reward')
    params.delete('QualificationRequirement')
    params.merge!('Reward.1.Amount' => reward[:Amount], 'Reward.1.CurrencyCode' => reward[:CurrencyCode])
    p params
    params
  end

end
