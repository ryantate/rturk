# Operation to retreive statistics about you
#
# http://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester
# &AWSAccessKeyId=[the Requester's Access Key ID]
# &Version=2008-08-02
# &Operation=GetRequesterStatistic
# &Signature=[signature for this request]
# &Timestamp=[your system's local time]
# &Statistic=TotalRewardPayout
# &TimePeriod=ThirtyDays
# &Count=1


module RTurk
  class GetRequesterStatistic < Operation
    require_params :statistic
    attr_accessor :statistic, :time_period

    STATISTICS = [
      "NumberAssignmentsAvailable",
      "NumberAssignmentsAccepted",
      "NumberAssignmentsPending",
      "NumberAssignmentsApproved",
      "NumberAssignmentsRejected",
      "NumberAssignmentsReturned",
      "NumberAssignmentsAbandoned",
      "PercentAssignmentsApproved",
      "PercentAssignmentsRejected",
      "TotalRewardPayout",
      "AverageRewardAmount",
      "TotalRewardFeePayout",
      "TotalFeePayout",
      "TotalRewardAndFeePayout",
      "TotalBonusPayout",
      "TotalBonusFeePayout",
      "NumberHITsCreated",
      "NumberHITsCompleted",
      "NumberHITsAssignable",
      "NumberHITsReviewable",
      "EstimatedRewardLiability",
      "EstimatedFeeLiability",
      "EstimatedTotalLiability"]

    def parse(xml)
      RTurk::GetRequesterStatisticResponse.new(xml)
    end

    def to_params
      {"Statistic" => statistic,
       "TimePeriod" => time_period || 'LifeToDate' # OneDay, SevenDays, ThirtyDays, LifeToDate
      }
    end
  end

  def self.GetRequesterStatistic(*args)
    RTurk::GetRequesterStatistic.create(*args)
  end
end
