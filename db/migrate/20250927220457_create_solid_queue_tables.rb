# This migration comes from solid_queue (originally 20230724122 solid_queue)
class CreateSolidQueueTables < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false, index: true
      t.string :class_name, null: false, index: true
      t.text :arguments
      t.integer :priority, default: 0, null: false
      t.string :active_job_id, index: true
      t.datetime :scheduled_at, index: true
      t.datetime :finished_at, index: true
      t.string :concurrency_key
      t.string :cron_key, index: true

      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index [ :concurrency_key, :finished_at ], name: "index_solid_queue_jobs_for_concurrency"
    end

    create_table :solid_queue_scheduled_executions do |t|
      t.references :job, index: { unique: true }, null: false
      t.string :queue_name, null: false, index: true
      t.integer :priority, default: 0, null: false
      t.datetime :scheduled_at, null: false, index: true
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_ready_executions do |t|
      t.references :job, index: { unique: true }, null: false
      t.string :queue_name, null: false, index: true
      t.integer :priority, default: 0, null: false
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_claimed_executions do |t|
      t.references :job, index: { unique: true }, null: false
      t.bigint :process_id
      t.datetime :created_at, null: false

      t.index [ :process_id, :job_id ], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
    end

    create_table :solid_queue_blocked_executions do |t|
      t.references :job, index: { unique: true }, null: false
      t.string :queue_name, null: false, index: true
      t.integer :priority, default: 0, null: false
      t.string :concurrency_key, null: false, index: { name: "index_solid_queue_blocked_executions_for_concurrency" }
      t.datetime :expires_at, null: false
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_pauses do |t|
      t.string :queue_name, null: false, index: { unique: true }
      t.datetime :created_at, null: false
    end

    create_table :solid_queue_semaphores do |t|
      t.string :key, null: false, index: { unique: true }
      t.integer :value, default: 1, null: false
      t.datetime :expires_at, null: false

      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    create_table :solid_queue_processes do |t|
      t.text :metadata
      t.datetime :created_at, null: false
      t.datetime :last_heartbeat_at, null: false, index: true
    end

    create_table :solid_queue_recurring_tasks do |t|
      t.string :key, null: false, index: { unique: true }
      t.string :schedule, null: false
      t.string :command, null: false
      t.text :arguments
      t.datetime :last_run_at
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    create_table :solid_queue_recurring_executions do |t|
      t.references :task, null: false, index: false
      t.datetime :run_at, null: false
      t.datetime :created_at, null: false

      t.index [ :task_id, :run_at ], unique: true
    end
  end
end
