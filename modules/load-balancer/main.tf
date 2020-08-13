resource "aws_lb" "emr_master_lb" {
  name               = "${var.name}-lb"
  load_balancer_type = "application"
  security_groups    = ["${var.lb_security_group}"]
  subnets            = flatten(["${var.subnet_ids}"])
}

resource "aws_lb_target_group" "jupyterhub" {
  name     = "${var.name}-jupyterhub-tg"
  port     = var.jupyter_port
  protocol = "HTTPS"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
    matcher  = "200"

    healthy_threshold   = 2
    unhealthy_threshold = 2

    interval = 10
    timeout  = 2
  }
}

resource "aws_lb_target_group_attachment" "jupyterhub" {
  target_group_arn = aws_lb_target_group.jupyterhub.arn
  target_id        = var.master_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "jh_ssl_redirect" {
  load_balancer_arn = aws_lb.emr_master_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.jupyterhub.arn
    type             = "redirect"
  }
}