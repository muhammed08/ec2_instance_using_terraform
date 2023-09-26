resource "aws_key_pair" "localKey"{
    key_name = "localKey"
    public_key = file("Keys.pub")
}

resource "aws_secretsmanager_secret" "my_secret" {
  name = "my-secret"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "attach_secrets_policy" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  roles      = [aws_iam_role.ec2_role.name]
  name       = "secretmanagerrole"
}

resource "aws_iam_instance_profile" "ec2profile" {
  name = "test_profile"
  role = aws_iam_role.ec2_role.name
}



resource "aws_instance" "app_server" {
  ami           = "ami-002829755fa238bfa"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-00e74230a47688404"]
  subnet_id ="subnet-014e4c5eb9089c41b"
  key_name = "localKey"
  iam_instance_profile = aws_iam_instance_profile.ec2profile.name

  tags = {
    Name = "instance1212"
  }
}