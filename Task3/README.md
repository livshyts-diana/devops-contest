
Вся інфраструктура побудована без використання захардкоджених AMI ID. Пошук образів відбувається динамічно при кожному запуску за допомогою блоків `data "aws_ami"`:

* Для Ubuntu шукається найсвіжіший офіційний реліз від Canonical за фільтром `ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*`.

* Для CentOS-сумісної системи використовується офіційний стабільний образ AL2023.

Згідно з уточненням до п.3, вихідний трафік (`egress`) для CentOS було заблоковано в інтернет та обмежено **виключно** до Security Group інстансу Ubuntu. Це реалізовано за допомогою крос-референсу SG у коді Terraform:

```hcl

egress {

  from_port       = 0

  to_port         = 0

  protocol        = "-1"

  security_groups = [aws_security_group.ubuntu_sg.id]

}
