import 'dart:async';

/// A generic key/value storage
abstract class KeyValueStorage<K, V> {
  /// Sets the value of [key] to [value]
  FutureOr set(K key, V value);

  /// Returns the value of [key]
  FutureOr<V?> get(K key);

  /// Clears the whole store
  ///
  /// # ⚠️ Be careful when calling it.
  /// # **It's irreversible!**
  FutureOr clear();

  /// Removes [key] from the store
  ///
  /// # ⚠️ Be careful when calling it.
  /// # **It's irreversible!**
  FutureOr remove(K key);
}
