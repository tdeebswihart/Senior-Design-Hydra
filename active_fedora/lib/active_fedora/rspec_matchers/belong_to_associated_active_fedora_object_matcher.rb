# RSpec matcher to spec delegations.
RSpec::Matchers.define :belong_to_associated_active_fedora_object do |association_name|
  match do |subject|
    @association_name = association_name
    if @association_name.nil? || @expected_object.nil?
      raise(
        ArgumentError,
        "subject.should belong_to_associated_active_fedora_object(<association_name>).with_object(<object>)"
      )
    end

    @subject = subject.class.find(subject.pid)
    @actual_object = @subject.send(@association_name)

    @expected_object == @actual_object
  end

  chain(:with_object) { |object| @expected_object = object }


  description do
    "#{@subject.class} PID=#{@subject.pid} association: #{@association_name.inspect} matches ActiveFedora"
  end

  failure_message_for_should do |text|
    "expected #{@subject.class} PID=#{@subject.pid} association: #{@association_name.inspect} to match"
  end

  failure_message_for_should_not do |text|
    "expected #{@subject.class} PID=#{@subject.pid} association: #{@association_name.inspect} to NOT match"
  end

end
