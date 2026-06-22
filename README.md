# Terraform Practice

Repositório utilizado para estudos, testes e práticas com Terraform.

## Objetivos

- Aprender os conceitos fundamentais do Terraform
- Praticar Infraestrutura como Código (IaC)
- Criar e gerenciar recursos em nuvem
- Organizar projetos utilizando módulos
- Explorar boas práticas de desenvolvimento com Terraform

## Estrutura do Projeto

```text
project-1/
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── modules/
│   ├── compartment/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── provider.tf
│   │
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── provider.tf
│   │
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── provider.tf
│
├── TERRAFORM-COMPARTMENT/
│   ├── .terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── .terraform.lock.hcl
│
├── COMPARTMENT-IMPORT-TERRAFORM/
│   ├── .terraform/
│   ├── data.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── .terraform.lock.hcl
│
├── .terraform/
├── .terraform.lock.hcl
├── .gitignore
├── README.md
├── terraform.tfstate
└── terraform.tfstate.backup
```

## Descrição

| Diretório/Arquivo              | Função                                                                                      |
| ------------------------------ | ------------------------------------------------------------------------------------------- |
| `.github/workflows`            | Pipeline CI/CD utilizando GitHub Actions                                                    |
| `modules/compartment`          | Módulo responsável pela criação e gerenciamento de Compartments na OCI                      |
| `modules/network`              | Módulo responsável pelos recursos de rede (VCN, Subnets, NSGs e rotas)                      |
| `modules/compute`              | Módulo responsável pelo provisionamento de instâncias Compute                               |
| `TERRAFORM-COMPARTMENT`        | Ambiente principal para provisionamento da infraestrutura utilizando módulos                |
| `COMPARTMENT-IMPORT-TERRAFORM` | Ambiente utilizado para importação e gerenciamento de recursos OCI existentes via Terraform |
| `provider.tf`                  | Configuração do provider Oracle Cloud Infrastructure (OCI)                                  |
| `variables.tf`                 | Declaração das variáveis utilizadas pelo ambiente                                           |
| `terraform.tfvars`             | Valores atribuídos às variáveis do ambiente                                                 |
| `outputs.tf`                   | Outputs exportados para consulta e integração entre módulos                                 |
| `data.tf`                      | Data sources utilizados para consultar recursos existentes na OCI                           |
| `.terraform/`                  | Diretório gerado automaticamente contendo providers e dependências                          |
| `.terraform.lock.hcl`          | Arquivo de bloqueio das versões dos providers                                               |
| `terraform.tfstate`            | Arquivo de estado do Terraform                                                              |
| `terraform.tfstate.backup`     | Backup automático do estado do Terraform                                                    |



### Arquitetura

- **Módulos reutilizáveis** localizados em `modules/`
- **Ambiente principal** em `TERRAFORM-COMPARTMENT`
- **Ambiente de importação/migração** em `COMPARTMENT-IMPORT-TERRAFORM`
- **CI/CD automatizado** através do GitHub Actions
- **Backend Terraform** configurado para armazenamento remoto do estado na OCI Object Storage
```
