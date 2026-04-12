enum MiddlewarePhase {
  preProcess, // deduplication, cache read
  guard, // network checks, auth, feature flags
  rateLimit, // debounce, throttle
  concurrency, // queueing, locking
  resilience, // retry, offline queue
  timeout, // execution bounds
  observability, // performance, logging
  postProcess, // cache write, analytics
}