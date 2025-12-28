# CloudWatch arlam that will monitor if the cpu is above 80 percent usage
resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "pranavissam-High-CPU-Alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60" # check every 60 seconds
  statistic           = "Average"
  threshold           = "80" # alert if CPU is above 80%
  alarm_description   = "This alarm monitors EC2 CPU utilization"

  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}

# this is to create a dashboard using cloudwatch
resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = "Pranavissam-Server-Health"

  dashboard_body = <<EOF
    {
    "widgets": [
        {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
            "metrics": [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", "${aws_instance.web_server.id}" ]
            ],
            "period": 300,
            "stat": "Average",
            "region": "us-east-1",
            "title": "EC2 CPU Utilization"
        }
        }
    ]
    }
    EOF
}