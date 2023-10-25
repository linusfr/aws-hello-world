# output "for_directive" {
#   value = "%{ for name in var.user_names }${name}, %{ endfor }"
# }

# output "for_directive_index" {
#   value = "%{ for i, name in var.user_names }(${i}) ${name}, %{ endfor }"
# }

output "for_directive_index_if" {
  value = <<EOF
%{~ for i, name in var.user_names ~}
  ${name}%{ if i < length(var.user_names) - 1 }, %{ else }.%{ endif }
%{~ endfor ~}
EOF
}
