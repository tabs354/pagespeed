module ApplicationHelper

  def progress(index)
    progress = [:success, :info, :danger]
    progress[index]
  end

  def get_data(data, content)
    data["metrics"][content]["category"]
  end

  def get_distribution(data, content)
    data["metrics"][content]["distributions"]
  end

  def set_proportion(distribution)
    distribution["proportion"] * 100
  end
end
