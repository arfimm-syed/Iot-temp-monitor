#Create Topics

resource "google_pubsub_topic" "topics" {

  for_each = var.pubsub

  project = var.project_id

  name = each.value.topic_name

  labels = each.value.labels

}

#Local Flatten

locals {

  subscriptions = merge([

    for topic_key, topic in var.pubsub : {

      for sub_key, sub in topic.subscriptions :

      "${topic_key}-${sub_key}" => {

        topic_key = topic_key

        topic_name = topic.topic_name

        subscription = sub

      }

    }

  ]...)

}

#Create Subscriptions

resource "google_pubsub_subscription" "subscriptions" {

  for_each = local.subscriptions

  project = var.project_id

  name = each.value.subscription.name

  topic = google_pubsub_topic.topics[each.value.topic_key].name

  ack_deadline_seconds = each.value.subscription.ack_deadline_seconds

  message_retention_duration = each.value.subscription.message_retention_duration

  enable_message_ordering = each.value.subscription.enable_message_ordering


#Retry Policy

dynamic "retry_policy" {

  for_each = each.value.subscription.retry_policy == null ? [] : [1]

  content {

    minimum_backoff = each.value.subscription.retry_policy.minimum_backoff

    maximum_backoff = each.value.subscription.retry_policy.maximum_backoff

  }

}

#Dead Letter Policy

dynamic "dead_letter_policy" {

  for_each = try(each.value.subscription.dead_letter.enabled, false) ? [1] : []

  content {

    dead_letter_topic = google_pubsub_topic.dead_letter[each.key].id

    max_delivery_attempts = each.value.subscription.dead_letter.max_delivery_attempt

  }
}

}

#Dead Letter Topics

locals {

  dead_letter_topics = {

    for k, v in local.subscriptions :

    k => v

    if try(v.subscription.dead_letter.enabled, false)

  }

}

resource "google_pubsub_topic" "dead_letter" {

  for_each = local.dead_letter_topics

  project = var.project_id

  name = each.value.subscription.dead_letter.topic_name

}





