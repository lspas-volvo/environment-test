format_version: 3
environments:
  ${environment}:
    pipelines:
      - ${app_name}_${environment}
pipelines:
  ${app_name}_${environment}:
    group: ${app_name}
    label_template: ${COUNT}
    lock_behavior: none
    display_order: -1
    materials:
      git:
        git: https://github.com/lspas-volvo/environments.git
        shallow_clone: true
        auto_update: true
        branch: master
        whitelist:
          - '${app_name}/${environment}.*'
          - '${app_name}/${environment}-*'
          - '${app_name}/${environment}_*'
          - '${app_name}/${environment}/*'
    stages:
    - default_stage:
        fetch_materials: true
        keep_artifacts: false
        clean_workspace: false
        approval:
          type: success
        jobs:
          default_job:
            timeout: 0
            elastic_profile_id: demo-app
            tasks:
            - exec:
                arguments:
                - Hello World
                command: echo
                run_if: passed
