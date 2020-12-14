class Job
  include AASM

  aasm do
    state :sleeping, initial: true, before_enter: :go_sleep
    state :running, :cleaning, :coding, :eating, :walking

    event :run do
      transitions from: :sleeping, to: :running 
    end

    event :clean do
      transitions from: :running, to: :cleaning
    end

    event :sleep do
      transitions from: [:running, :cleaning, :walking], to: :sleeping, guard: :is_eating
    end

    event :code do
      transitions from: [:sleeping, :eating],  to: :coding, after: :go_code
    end

    event :eat do
      transitions from: [:running, :coding, :cleaning], to: :eating, after: :go_eat
    end
  end

  def is_eating
    true
  end

  def go_sleep
    p 'going to sleep'
  end
  def go_eat
    p 'going to eat'
  end
  def go_code
    p 'going to code'
  end

end