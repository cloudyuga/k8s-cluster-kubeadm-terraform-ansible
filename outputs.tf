output "master" {
  value = aws_instance.k8s_master.public_ip
<<<<<<< HEAD
=======
}

output "workers" {
  value = aws_instance.k8s_worker[*].public_ip
>>>>>>> 456cddac11ca2cb947317261adb90f308161ae70
}